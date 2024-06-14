pipeline{
    agent any 
    
    parameters{
        choice(name:'Action',choices:['plan','apply','destroy'],description:'Select the action to be performed')
        booleanParam(name:'ApplyApproval',defaultValue:false,description:'Are you confirming terraform apply')
        booleanParam(name:'DestroyApproval',defaultValue:false,description:'Are you confirming terraform destroy')
     }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        IMAGE_REPO_NAME = "new-cluster-repo"
        AWS_REGION = 'us-east-1'
        ECR_URL= "211125415675.dkr.ecr.${AWS_REGION}.amazonaws.com"
    }
    
    stages{
        stage('Checkout Code'){
            steps{
                script{
                     git branch: 'master',url:'https://github.com/skykesavanke/Cluster_Creation.git'
                }
               
        }
            }

        stage('Terraform Initialize'){
             steps{
                 bat 'C:\\Users\\kesavank\\Terraform\\terraform init'
        }
    }
        stage('Terraform run'){
           steps{
             script{
                if(params.Action=='plan'){
                    bat 'C:\\Users\\kesavank\\Terraform\\terraform plan'
                }
                else if(params.Action=='apply'){
                    if(params.ApplyApproval){
                         bat 'C:\\Users\\kesavank\\Terraform\\terraform apply -auto-approve'
                    }
                    else{
                        echo "Apply Approval required"
                    }
                }
                else if(params.Action=='destroy'){
                    if(params.DestroyApproval){
                        bat 'C:\\Users\\kesavank\\Terraform\\terraform destroy -auto-approve'
                    }
                    else {
                        echo "Destroy approval required"
                    }
                }
               
                else {
                        error "Invalid action: ${params.Action}"
                    }
                
             }
           }
        }
         stage('Image Build'){
           steps{
             script{
                
                    def imageRepoName = "${env.IMAGE_REPO_NAME}"
                    def awsRegion = "${env.AWS_REGION}"
                    def ecrUrl = "211125415675.dkr.ecr.${awsRegion}.amazonaws.com"

                        
                        bat """
                                set IMAGE_REPO_NAME=${imageRepoName}
                                set AWS_REGION=${awsRegion}
                                set ECR_URL=${ecrUrl}

                                aws ecr get-login-password --region %AWS_REGION% | docker login --username AWS --password-stdin  %ECR_URL%
                                docker build -t  %IMAGE_REPO_NAME% .
                                docker tag %IMAGE_REPO_NAME%:latest %ECR_URL%/%IMAGE_REPO_NAME%:latest
                                docker push  %ECR_URL%/%IMAGE_REPO_NAME%:latest
                       """
                    } 
                    
             }  
    }

        stage('Trigger Deployment Pipeline'){
            steps{
                build job : 'Deployment_of_cluster'
            }
        }
    }
}

    



  
       


                   
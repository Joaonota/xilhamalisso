

class Chamada{
  String chamadaID;
  String chamadaNome;
  String chamadaPic;
  String receiverID;
  String receiverName;
  String receiverPic;
  String channelID;
  bool hasDisabled;

  Chamada({
  this.chamadaID,
  this.chamadaNome,
  this.chamadaPic,
  this.receiverID,
  this.receiverName,
  this.receiverPic,
  this.channelID,
  this. hasDisabled
  });

  Map <String, dynamic>toMap(Chamada chamada){
    Map <String, dynamic>callMap = Map();

  callMap['chamada_ID']=chamada.chamadaID; 
   callMap['chamada_Nome']=chamada.chamadaNome; 
    callMap['chamada_Pic']=chamada.chamadaPic; 
     callMap['receiver_ID']=chamada.receiverID; 
      callMap['receiver_Name']=chamada.receiverName; 
      callMap['receiver_Pic']=chamada.receiverPic; 
      callMap['channel_ID']=chamada.channelID; 
      callMap['has_Disabled']=chamada.hasDisabled; 
      return callMap;
}
Chamada.fromMap(Map callMap){
  this.chamadaID=callMap['chamada_ID']; 
   this.chamadaNome=callMap['chamada_Nome']; 
    this.chamadaPic=callMap['chamada_Pic']; 
    this.receiverID= callMap['receiver_ID']; 
     this.receiverName= callMap['receiver_Name']; 
      this.receiverPic=callMap['receiver_Pic']; 
      this.channelID=callMap['channel_ID']; 
      this.hasDisabled=callMap['has_Disabled'];

}
  

}
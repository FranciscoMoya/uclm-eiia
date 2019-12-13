var e = document.evaluate( "//span/i[contains(., 'enrolled')]", document, null, XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE, null );
for (var i=0 ; i < e.snapshotLength; i++){
   e.snapshotItem(i).style.display = "none";
}


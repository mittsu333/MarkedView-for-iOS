$(function() {

    marked.setOptions({
        langPrefix: ''
    });
  
    preview = function setMarkdown(md_text){
        // jsでバリデーションチェックをするときはboolean値を設定するのが作法
        if(md_text == "") return false;
  
        // markdown html
        var md_html = marked(md_text);
        // html上に表示する
        $('#preview').html(md_html);
        // コードブロックにハイライトを追加
        $('pre code').each(function(i, block) {
            hljs.highlightBlock(block);
        });
    };
});
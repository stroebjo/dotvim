let s:TransmitFtpAppleScript=expand("<sfile>:h:h")."/apple/send_to_transmit.applescript"
fun! TransmitFtpSendFile()
    let TransmitFtpFileName = expand("%:p")
    silent exec '!osascript ' .shellescape(s:TransmitFtpAppleScript, 1) . ' ' . shellescape(TransmitFtpFileName, 1)
    echo "File " . TransmitFtpFileName . " sent to Transmit" 
endfunction

nnoremap <C-S-U> :call TransmitFtpSendFile()<CR>

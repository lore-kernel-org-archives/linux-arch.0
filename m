From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: parisc: kernel: using strlcpy() instead of strcpy()
Date: Mon, 03 Jun 2013 16:50:03 +0800
Message-ID: <51AC58BB.20305@asianux.com>
References: <51A6A8F3.2030200@asianux.com> <20130530150636.GA2121@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20130530150636.GA2121@udknight>
Sender: linux-parisc-owner@vger.kernel.org
To: Wang YanQing <udknight@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Greg KH <gregkh@linuxfoundation.org>, Parisc List <linux-parisc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 05/30/2013 11:06 PM, Wang YanQing wrote:
> What about add 
> boot_command_line[COMMAND_LINE_SIZE - 1] = '\0';
> to protect the following another strcpy?
> 
> "
> strcpy(command_line, boot_command_line);
> "

If the 'dest' length is not less than COMMAND_LINE_SIZE, the strlcpy()
will copy 'COMMAND_LINE_SIZE - 1' contents, and always set '\0' in the end.

So the next strcpy() will be safe.


Thanks.
-- 
Chen Gang

Asianux Corporation

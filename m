From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [PATCH 1/4] alpha: belated ERESTART_RESTARTBLOCK race fix
Date: Sun, 19 Sep 2010 14:46:57 +1200
Message-ID: <4C9579A1.5030009@orcon.net.nz>
References: <20100918083846.GA31363@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20100918083846.GA31363@ZenIV.linux.org.uk>
Sender: linux-alpha-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, mattst88@gmail.com
List-Id: linux-arch.vger.kernel.org

On 18/09/10 20:38, Al Viro wrote:
> same thing as had been done on other targets back in 2003 -
> move setting ->restart_block.fn into {rt_,}sigreturn().
>
> Signed-off-by: Al Viro<viro@zeniv.linux.org.uk>

For the patch series:

Tested-by: Michael Cree <mcree@orcon.net.nz>

Cheers
Michael.

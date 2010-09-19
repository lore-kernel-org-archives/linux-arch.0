From: Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH 1/4] alpha: belated ERESTART_RESTARTBLOCK race fix
Date: Sun, 19 Sep 2010 00:50:34 -0400
Message-ID: <AANLkTimPZ5=FBdffeeDVB0_=no-rQcdEOdZ0OqLXkpss@mail.gmail.com>
References: <20100918083846.GA31363@ZenIV.linux.org.uk> <4C9579A1.5030009@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <4C9579A1.5030009@orcon.net.nz>
Sender: linux-alpha-owner@vger.kernel.org
To: Michael Cree <mcree@orcon.net.nz>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 18, 2010 at 10:46 PM, Michael Cree <mcree@orcon.net.nz> wrote:
> On 18/09/10 20:38, Al Viro wrote:
>>
>> same thing as had been done on other targets back in 2003 -
>> move setting ->restart_block.fn into {rt_,}sigreturn().
>>
>> Signed-off-by: Al Viro<viro@zeniv.linux.org.uk>
>
> For the patch series:
>
> Tested-by: Michael Cree <mcree@orcon.net.nz>
>
> Cheers
> Michael.
>

Thanks for the test.

Al, I've vacuumed your patches and sent them with others in a pull
request to Linus.

Thanks a ton. Anyone who finds and fixes a 14 year-old bug, well, I
owe you a beer.

Thanks!
Matt

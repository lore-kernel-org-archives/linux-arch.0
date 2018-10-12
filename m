From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
Date: Fri, 12 Oct 2018 16:03:35 +0200
Message-ID: <24dae8ebfd18a60e844383ae4beed486@sf-tec.de>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-4-git-send-email-firoz.khan@linaro.org>
 <c6280818c999449646ec216984f2df9e@sf-tec.de>
 <CALxhOnggUEkXVVupq0SebJV0StKqbTTCqQtaaao+oQveUFHgbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOnggUEkXVVupq0SebJV0StKqbTTCqQtaaao+oQveUFHgbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, linux-parisc-owner@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Firoz Khan wrote:

>> > +
>> > +    my_abi="$(cut -d'|' -f2 <<< $my_abis)"
> 
> Here is the logic of identifying the generated script is for compat 
> interface
> or not. So systbl_abi_syscall_table_c32 := common,compat,32 in Makefile
> will parse the script and check the second string whether this is
> "compat" or not.
> 
> Other ways are:
> 1. add an extra flag, that will again add the complexity
> 2. check if [ ${out: -5} = "c32.h" ], this looks weird
> 
> Is there any better way to do the same?

What part is that comment directed at? I guess it's the next hunk, so 
I'll comment on that.

>> "<<<" is a bash extension and will not work with /bin/sh.
>> 
>> > +    while read nr abi name entry compat ; do
>> > +     if [ $my_abi = "compat" ]; then
>> > +         if [ -z "$compat" ]; then
>> > +             emit $nxt $nr $entry
>> > +         else
>> > +             emit $nxt $nr $compat
>> > +         fi
>> > +     else
>> > +         emit $nxt $nr $entry
>> > +     fi
>> 
>> I would go for a local variable being set to $compat or $entry and
>> calling emit at only one place. And there should be only one if with 2
>> expressions, no need for 3 branches.

if [ $my_abi = "compat" -a -n "${compat}" ]; then
     somevar=${compat}
else
     somevar=${entry}
fi
emit $nxt $nr $somevar

Eike

From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 01/29] arc: Use get_signal() signal_setup_done()
Date: Tue, 08 Oct 2013 17:59:00 +0200
Message-ID: <52542BC4.5010404@nod.at>
References: <1381231701-4008-1-git-send-email-richard@nod.at> <1381231701-4008-2-git-send-email-richard@nod.at> <52541313.4020101@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <52541313.4020101@synopsys.com>
Sender: linux-sh-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, vapier@gentoo.org, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, yasutake.koichi@jp.panasonic.com, ralf@linux-mips.org, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, linux-sh@vger.kernel.org, cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, linux-xtensa@linux-xtensa.org, akpm@linux-foundation.org, oleg@redhat.com, tj@kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Vineet,

Am 08.10.2013 16:13, schrieb Vineet Gupta:
> Hi Richard/all,
> 
> Sorry if this is repost - it seems the bounce back from Paul Mundt caused my
> earlier reply to not be posted to list. I wonder how other are managing to reply
> to thread or is that a Synopsys email server quirk.

/me got your first mail.

> Anyways,
> 
> On 10/08/2013 04:57 PM, Richard Weinberger wrote:
>> Use the more generic functions get_signal() signal_setup_done()
>> for signal delivery.
> 
> I never realized Al has added the infrastructure already (back when ARC port was
> being discussed for mainlining)
> 
> Since you are touching all arches, it might make sense to also throw in sigsp()
> replacement too.
> 
> Something like below:
> 
> -    if ((ka->sa.sa_flags & SA_ONSTACK) && !sas_ss_flags(sp))
> -        sp = current->sas_ss_sp + current->sas_ss_size;
> 
> 

Good idea. I can think of more sure helpers.

>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  arch/arc/kernel/signal.c | 39 +++++++++++++++------------------------
>>  1 file changed, 15 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
>> index 7e95e1a..c2031e2 100644
>> --- a/arch/arc/kernel/signal.c
>> +++ b/arch/arc/kernel/signal.c
>> @@ -179,14 +179,13 @@ static inline int map_sig(int sig)
>>  }
>>  
>>  static int
>> -setup_rt_frame(int signo, struct k_sigaction *ka, siginfo_t *info,
>> -	       sigset_t *set, struct pt_regs *regs)
>> +setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
>>  {
>>  	struct rt_sigframe __user *sf;
>>  	unsigned int magic = 0;
>>  	int err = 0;
>>  
>> -	sf = get_sigframe(ka, regs, sizeof(struct rt_sigframe));
>> +	sf = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe));
> 
> At least for ARC, it is possible to change get_sigframe() first arg to be ksignal
> as well. Rest of changes look good.
> 
> Thanks for the series !
> 
> P.S. I wonder how u r going to achieve closure on this since SH folks have not
> been responding. A patch series of mine is stuck in mid air due to lack of ACK/NAK
> from them.

I hope that the series can be merged via Al Viro's signal tree or so.
Moving single patches through X arch tree would be a PITA.
Especially because not all maintainers are reactive.

Thanks,
//richard

From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Date: Thu, 20 Dec 2018 18:45:48 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642389B@US01WEMBX2.internal.synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
 <20181220130450.GB17350@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On 12/20/18 5:04 AM, Michal Hocko wrote:=0A=
> On Tue 18-12-18 10:53:59, Vineet Gupta wrote:=0A=
>> signal handling core calls ARCH show_regs() with preemption disabled=0A=
>> which causes __might_sleep functions such as mmput leading to lockdep=0A=
>> splat.  Workaround by re-enabling preemption temporarily.=0A=
>>=0A=
>> This may not be as bad as it sounds since the preemption disabling=0A=
>> itself was introduced for a supressing smp_processor_id() warning in x86=
=0A=
>> code by commit 3a9f84d354ce ("signals, debug: fix BUG: using=0A=
>> smp_processor_id() in preemptible code in print_fatal_signal()")=0A=
> The commit you are referring to here sounds dubious in itself.=0A=
=0A=
Indeed that was my thought as well, but it did introduce the preemption dis=
abling=0A=
logic aroung core calling show_regs() !=0A=
=0A=
> We do not=0A=
> want to stick a preempt_disable just to silence a warning.=0A=
=0A=
I presume you are referring to original commit, not my anti-change in ARC c=
ode,=0A=
which is actually re-enabling it.=0A=
=0A=
> show_regs is=0A=
> called from preemptible context at several places (e.g. __warn).=0A=
=0A=
Right, but do we have other reports which show this, perhaps not too many d=
istros=0A=
have CONFIG__PREEMPT enabled ?=0A=
=0A=
> Maybe=0A=
> this was not the case in 2009 when the change was introduced but this=0A=
> seems like a relict from the past. So can we fix the actual problem=0A=
> rather than build on top of it instead?=0A=
=0A=
The best/correct fix is to remove the preempt diabling in core code, but th=
at=0A=
affects every arch out there and will likely trip dormant land mines, neede=
d=0A=
localized fixes like I'm dealing with now.=0A=
=0A=
-Vineet=0A=

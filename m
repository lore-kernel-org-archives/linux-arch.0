Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:35920 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbfGQRqH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 13:46:07 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Date: Wed, 17 Jul 2019 17:45:52 +0000
Message-ID: <BN6PR1201MB0035E304FF25609CBCACBD09B6C90@BN6PR1201MB0035.namprd12.prod.outlook.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <57076361ad37f4fe7a5584643ae47adf30a99d35.camel@synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "peterz@infradead.org" <peterz@infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "jbaron@redhat.com" <jbaron@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190717174552.LeVje-JwhK_scWIEv6Oo3UdRSEeNpW6Oy57QVm8WqMQ@z>

On 7/17/19 8:09 AM, Eugeniy Paltsev wrote:=0A=
>>> +/* Halt system on fatal error to make debug easier */=0A=
>>> +#define arc_jl_fatal(format...)						\=0A=
>>> +({									\=0A=
>>> +	pr_err(JUMPLABEL_ERR format);					\=0A=
>>> +	BUG();								\=0A=
>> Does it make sense to bring down the whole system vs. failing and return=
ing.=0A=
>> I see there is no error propagation to core code, but still.=0A=
> I totally agree with Peter, and I prefer to stop the system on this error=
s. Here is few arguments:=0A=
> All this checks can't be toggle in system operating normally and only may=
 be caused by bad code generation (or some code/data corruption):=0A=
> 1) We got our instruction to patch unaligned by 4 bytes (despite the fact=
 that we used '.balign 4' to align it)=0A=
> 2) We got branch offset unaligned (which means that we calculate it wrong=
 at build time or corrupt it in run time)=0A=
> 3) We got branch offset which not fits into s25. As this is offset inside=
 one function (inside one 'if' statement actually) we newer get such huge=
=0A=
> offset in real life if code generation is ok.=0A=
=0A=
I understand that. But AFAIKR in implementation arc_jl_fatal() gets called =
before=0A=
we have done the actual code patching and/or flushing the caches to that ef=
fect.=0A=
So harm has been done just yet. We just need to make sure that any book-kee=
ping of=0A=
true/false is not yet done or unrolled.=0A=
=0A=
> If we only warn to log and return we will face with compromised kernel fl=
ow later.=0A=
> I.E. it could be 'if' statement in kernel text which is switched to wrong=
 state: the condition is true but we take the false branch.=0A=
> And It will be the issue which is much more difficult to debug.=0A=
>=0A=
> Does it sound reasonably?=0A=
=0A=
I'm still not convinced that by hitting the _fatal() we are in some inconsi=
stent=0A=
state already. But if u feel strongly lets keep it.=0A=
=0A=
>=0A=
> If you really don't want to have BUG here, I can make it conditionally en=
abled=0A=
=0A=
Not a good idea. It is unconditionally present or not. Not something in bet=
ween.=0A=
=0A=
> in depend on CONFIG_ARC_STATIC_KEYS_DEBUG as I want to have it enabled at=
 least on ARC development platforms.=0A=
=0A=
=0A=

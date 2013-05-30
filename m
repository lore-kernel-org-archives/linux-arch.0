From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: m68k: math-emu: unsigned issue, 'unsigned long'
 will never be less than zero.
Date: Thu, 30 May 2013 16:08:54 +0800
Message-ID: <51A70916.40101@asianux.com>
References: <51A6F0C6.9050806@asianux.com> <m2a9ndndu5.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <m2a9ndndu5.fsf@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 05/30/2013 03:09 PM, Andreas Schwab wrote:
> Chen Gang <gang.chen@asianux.com> writes:
> 
>> > 'oldmant.m32[1]' is 'unsigned long' which never '< 0', and the original
>> > author wanted to check the highest bit whether set.
>> >
>> > So need type cast form 'unsigned long' to 'long'.
> Better to make the bit test explicit, since it is not a sign bit.
> 

That sounds good.


>> > diff --git a/arch/m68k/math-emu/fp_arith.c b/arch/m68k/math-emu/fp_arith.c
>> > index 08f286d..ef013c5 100644
>> > --- a/arch/m68k/math-emu/fp_arith.c
>> > +++ b/arch/m68k/math-emu/fp_arith.c
>> > @@ -519,7 +519,7 @@ static void fp_roundint(struct fp_ext *dest, int mode)
>> >  				return;
>> >  			break;
>> >  		case 0x401e:
>> > -			if (!(oldmant.m32[1] >= 0))
>> > +			if (!((long)oldmant.m32[1] >= 0))
> 			if (oldmant.m32[1] & 0x80000000)

OK, I will send patch v2.


Thanks.
-- 
Chen Gang

Asianux Corporation

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:50772 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbfFCV7H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 17:59:07 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Date: Mon, 3 Jun 2019 21:59:03 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2523460@us01wembx1.internal.synopsys.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
 <20190603201324.GN28207@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190603215903.GuvsTzSfAK3ZyqDz7tIEQi6g-Lz8sEugp1W1pIDl7_Q@z>

On 6/3/19 1:13 PM, Paul E. McKenney wrote:=0A=
> On Mon, Jun 03, 2019 at 06:08:35PM +0000, Vineet Gupta wrote:=0A=
>> On 5/31/19 1:21 AM, Peter Zijlstra wrote:=0A=
>>>> I'm not sure how to interpret "natural alignment" for the case of doub=
le=0A=
>>>> load/stores on 32-bit systems where the hardware and ABI allow for 4 b=
yte=0A=
>>>> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)=0A=
>>> Natural alignment: !((uintptr_t)ptr % sizeof(*ptr))=0A=
>>>=0A=
>>> For any u64 type, that would give 8 byte alignment. the problem=0A=
>>> otherwise being that your data spans two lines/pages etc..=0A=
>> Sure, but as Paul said, if the software doesn't expect them to be atomic=
 by=0A=
>> default, they could span 2 hardware lines to keep the implementation sim=
pler/sane.=0A=
> I could imagine 8-byte types being only four-byte aligned on 32-bit syste=
ms,=0A=
> but it would be quite a surprise on 64-bit systems.=0A=
=0A=
Totally agree !=0A=
=0A=
Thx,=0A=
-Vineet=0A=

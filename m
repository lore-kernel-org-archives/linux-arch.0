From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Date: Mon, 3 Jun 2019 18:08:35 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <Will.Deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 5/31/19 1:21 AM, Peter Zijlstra wrote:=0A=
>> I'm not sure how to interpret "natural alignment" for the case of double=
=0A=
>> load/stores on 32-bit systems where the hardware and ABI allow for 4 byt=
e=0A=
>> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)=0A=
> Natural alignment: !((uintptr_t)ptr % sizeof(*ptr))=0A=
>=0A=
> For any u64 type, that would give 8 byte alignment. the problem=0A=
> otherwise being that your data spans two lines/pages etc..=0A=
=0A=
Sure, but as Paul said, if the software doesn't expect them to be atomic by=
=0A=
default, they could span 2 hardware lines to keep the implementation simple=
r/sane.=0A=

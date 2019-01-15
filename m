From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v4 00/24] Unify vDSOs across more architectures
Date: Tue, 15 Jan 2019 15:46:53 +0000
Message-ID: <efae0a15-9560-7bc3-e008-1ffa0f9b9297@arm.com>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1901151630120.1561@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1901151630120.1561@nanos.tec.linutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 15/01/2019 15:31, Thomas Gleixner wrote:
> On Tue, 15 Jan 2019, Vincenzo Frascino wrote:
>>
>> This implementation contains the portings to the common library for: arm64,
>> compat mode for arm64, arm and mips.
> 
> And as you already copied most of the implementation from x86, then why is
> there no port of the x86 vdso ?
>

Did not think of doing that, but it is certainly something that can be done. I
will add it to v5.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo

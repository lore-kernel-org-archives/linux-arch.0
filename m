From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Date: Tue, 13 Nov 2018 10:36:49 +0000
Message-ID: <a9726884-70e5-bff4-555d-cd870a5bd6db@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <CAMn1gO5tmJDXEgAZefcOmp1E2LmG3uqbO7vFwZRxAy2Cny114g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMn1gO5tmJDXEgAZefcOmp1E2LmG3uqbO7vFwZRxAy2Cny114g@mail.gmail.com>
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
To: Peter Collingbourne <pcc@google.com>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, daniel.lezcano@linaro.org, will.deacon@arm.com, linux@armlinux.org.uk, ralf@linux-mips.org, salyzyn@android.com, paul.burton@mips.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi Peter,

thank you for your review.

On 09/11/2018 18:09, Peter Collingbourne wrote:
> On Fri, Nov 9, 2018 at 4:38 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>> -ccflags-y := -shared -fno-common -fno-builtin
>> +ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector
> 
> This either needs to include -ffixed-x18 or
> https://patchwork.kernel.org/patch/10671685/ needs to appear earlier
> in this series.
> 

I did not add -ffixed-x18 to my flags because I was planning to cherry-pick your patch. It will be in v2.

> Peter
> 

-- 
Regards,
Vincenzo

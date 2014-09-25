From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/17] asm-generic: io: implement relaxed accessor macros as conditional wrappers
Date: Thu, 25 Sep 2014 12:32 +0200
Message-ID: <4501051.vdxhyhkTWv@wuerfel>
References: <1411579056-16966-1-git-send-email-will.deacon@arm.com> <1411579056-16966-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411579056-16966-2-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, chris@zankel.net, cmetcalf@tilera.com, davem@davemloft.net, deller@gmx.de, dhowells@redhat.com, geert@linux-m68k.org, heiko.carstens@de.ibm.com, hpa@zytor.com, jcmvbkbc@gmail.com, jesper.nilsson@axis.com, mingo@redhat.com, monstr@monstr.eu, paulmck@linux.vnet.ibm.com, rdunlap@infradead.org, sam@ravnborg.org, schwidefsky@de.ibm.com, starvik@axis.com, takata@linux-m32r.org, tglx@linutronix.de, tony.luck@intel.com, daniel.thompson@linaro.org, broonie@linaro.org, linux@arm.linux.org.uk
List-Id: linux-arch.vger.kernel.org

On Wednesday 24 September 2014 18:17:20 Will Deacon wrote:
> {read,write}{b,w,l,q}_relaxed are implemented by some architectures in
> order to permit memory-mapped I/O accesses with weaker barrier semantics
> than the non-relaxed variants.
> 
> This patch adds wrappers to asm-generic so that drivers can rely on the
> relaxed accessors being available, even if they don't always provide
> weaker ordering guarantees. Since some architectures both include
> asm-generic/io.h and define some relaxed accessors, the definitions here
> are conditional for the time being.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/asm-generic/io.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

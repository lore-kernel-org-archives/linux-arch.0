From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Date: Tue, 28 Apr 2020 16:18:16 +0100
Message-ID: <20200428151815.GB12697@willie-the-truck>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200422154436.GJ4898@sirena.org.uk> <20200422162954.GF3585@gaia>
 <20200428132804.GF6791@willie-the-truck>
 <20200428151205.GH5677@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200428151205.GH5677@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Jones <drjones@redhat.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Sudak
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 28, 2020 at 04:12:05PM +0100, Mark Brown wrote:
> On Tue, Apr 28, 2020 at 02:28:05PM +0100, Will Deacon wrote:
> 
> > I'm happy either way, but it would be nice to base other BTI patches on
> > top of this branch. Mark -- is it easier for you to refresh the series
> > against v5.7-rc3, or leave it like it is? Please just let me know either
> > way.
> 
> It's probably easier for me if you just use the existing branch, I've
> already got a branch based on a merge down.

Okey doke, I'll funnel that in the direction of linux-next then. It does
mean that any subsequent patches for 5.8 that depend on BTI will need to
be based on this branch, so as long as you're ok with that then it's fine
by me (since I won't be able to apply patches if they refer to changes
introduced in the recent merge window).

Will

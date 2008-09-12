From: Roland McGrath <roland@redhat.com>
Subject: Re: CONFIG_HAVE_ARCH_TRACEHOOK and you
Date: Fri, 12 Sep 2008 15:31:56 -0700 (PDT)
Message-ID: <20080912223156.51D4815420D@magilla.localdomain>
References: <20080912025733.E55F415420D@magilla.localdomain>
	<20080912131351.GA31545@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <utrace-devel-bounces@redhat.com>
In-Reply-To: Russell King's message of  Friday,
	12 September 2008 14:13:51 +0100
	<20080912131351.GA31545@flint.arm.linux.org.uk>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/utrace-devel>,
	<mailto:utrace-devel-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/utrace-devel>
List-Post: <mailto:utrace-devel@redhat.com>
List-Help: <mailto:utrace-devel-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/utrace-devel>,
	<mailto:utrace-devel-request@redhat.com?subject=subscribe>
Sender: utrace-devel-bounces@redhat.com
Errors-To: utrace-devel-bounces@redhat.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, utrace-devel@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

> clean.  The only thing I did do was invent some alternative simpler
> helper functions rather than using the user_regset_copy* functions (to
> avoid taking the address of function arguments, which needlessly forces
> them onto the stack.)

Ideally those would get inlined so that doesn't happen.  Their only purpose
is to make it easier to write get/set functions in arch code.  Whatever you
find preferable in your arch code is certainly fine with me.  If you have
something different, or changes to those regset.h functions, that would be
of use for other arch code too, then bring them on (under a new subject
line if you don't mind).

> means sparc ends up allocating 38 * sizeof(u32) * sizeof(u32), and
> sparc64 ends up with 36 * sizeof(u64) * sizeof(u64), which must surely
> be wrong?

Yup!  Sure looks like Dave skipped the step where it says "test that core
dumps work ... and produce correct results". :-)


Thanks,
Roland

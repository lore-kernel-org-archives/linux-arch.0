From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 2/3] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Date: Wed, 21 Aug 2019 18:35:01 +0100
Message-ID: <20190821173501.brvyn5mm5oh6m2s7@willie-the-truck>
References: <20190821164730.47450-1-catalin.marinas@arm.com>
 <20190821164730.47450-3-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190821164730.47450-3-catalin.marinas@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Dave P Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 21, 2019 at 05:47:29PM +0100, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> On AArch64 the TCR_EL1.TBI0 bit is set by default, allowing userspace
> (EL0) to perform memory accesses through 64-bit pointers with a non-zero
> top byte. Introduce the document describing the relaxation of the
> syscall ABI that allows userspace to pass certain tagged pointers to
> kernel syscalls.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  Documentation/arm64/tagged-address-abi.rst | 156 +++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/arm64/tagged-address-abi.rst

Thanks, I'll pick this on up.

Will

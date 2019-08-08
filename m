From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Date: Thu, 8 Aug 2019 16:30:01 +0000
Message-ID: <c73e76dd-de90-f5de-7809-5118270471c8@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190807155321.9648-2-catalin.marinas@arm.com>
Content-Language: en-US
Content-ID: <2416489F113EC049B7C1E80E7213516F@eurprd08.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <Kevin.Brodsky@arm.com>, Will Deacon <Will.Deacon@arm.com>, Dave Hansen <dave.hansen@intel.com>, nd <nd@arm.com>
List-Id: linux-arch.vger.kernel.org

On 07/08/2019 16:53, Catalin Marinas wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> On arm64 the TCR_EL1.TBI0 bit has been always enabled hence
> the userspace (EL0) is allowed to set a non-zero value in the
> top byte but the resulting pointers are not allowed at the
> user-kernel syscall ABI boundary.
> 
> With the relaxed ABI proposed through this document, it is now possible
> to pass tagged pointers to the syscalls, when these pointers are in
> memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().

description needs to be updated not to restrict tags
to anon mmap.

> +3. AArch64 Tagged Address ABI Exceptions
> +-----------------------------------------
> +
> +The behaviour described in section 2, with particular reference to the
> +acceptance by the syscalls of any valid tagged pointer, is not applicable
> +to the following cases:
> +
> +- mmap() addr parameter.
> +
> +- mremap() new_address parameter.
> +
> +- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
> +  PR_SET_MM_MAP_SIZE.
> +
> +- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.
> +
> +Any attempt to use non-zero tagged pointers will lead to undefined
> +behaviour.

i think that brk may be affected too by whatever that's
causing problems in mmap.

otherwise the text looks good to me.

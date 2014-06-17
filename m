From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 08/24] Allow a 32bit ABI to use the naming of the 64bit
 ABI syscalls to avoid confusion of not splitting the registers.
Date: Tue, 17 Jun 2014 17:22:15 +0100
Message-ID: <20140617162215.GF21752@arm.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
 <1400914939-9708-9-git-send-email-apinski@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1400914939-9708-9-git-send-email-apinski@cavium.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Pinski <apinski@cavium.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Sat, May 24, 2014 at 12:02:03AM -0700, Andrew Pinski wrote:
> In the ARM64 ILP32 case, we want to say the syscalls that normally
> would pass 64bit as two arguments are now passing as one so want to
> use the 64bit naming scheme.
> 
> Signed-off-by: Andrew Pinski <apinski@cavium.com>
> ---
>  include/uapi/asm-generic/unistd.h |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 3336406..0648659 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -875,8 +875,11 @@ __SYSCALL(__NR_fork, sys_ni_syscall)
>   * they take different names.
>   * Here we map the numbers so that both versions
>   * use the same syscall table layout.
> + * For 32bit abis where 64bit can be passed via one
> + * register, use the same naming as the 64bit ones
> + * as they will only have a 64 bit off_t.
>   */
> -#if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
> +#if (__BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)) || defined(__SYSCALL_NONCOMPAT)
>  #define __NR_fcntl __NR3264_fcntl
>  #define __NR_statfs __NR3264_statfs
>  #define __NR_fstatfs __NR3264_fstatfs

I can see why you are defining this. For compat, we don't expose
__SYSCALL_COMPAT to user. But this to work with ILP32 UAPI headers we
would have to define __SYSCALL_NONCOMPAT in the arm64 uapi unistd.h if
!__LP64__. I think we should use some naming closer to what we expose
via UAPI already (on other architectures) like
__ARCH_WANT_64BIT_SYSCALLS (or maybe we could reuse
__ARCH_WANT_SYSCALL_OFF_T).

-- 
Catalin

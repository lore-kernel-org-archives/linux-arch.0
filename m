Return-Path: <SRS0=V2YN=5S=kvack.org=owner-linux-mm@kernel.org>
Date: Thu, 2 Apr 2020 00:46:56 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Message-ID: <202004020046.96A2D21F@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
Sender: owner-linux-mm@kvack.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200402074656.Cel0Yfli5_VkiktTYa1Tv32AaHuiWo7faUKlYbK7yNY@z>

On Thu, Apr 02, 2020 at 07:34:16AM +0000, Christophe Leroy wrote:
> Some architectures like powerpc64 have the capability to separate
> read access and write access protection.
> For get_user() and copy_from_user(), powerpc64 only open read access.
> For put_user() and copy_to_user(), powerpc64 only open write access.
> But when using unsafe_get_user() or unsafe_put_user(),
> user_access_begin open both read and write.
> 
> Other architectures like powerpc book3s 32 bits only allow write
> access protection. And on this architecture protection is an heavy
> operation as it requires locking/unlocking per segment of 256Mbytes.
> On those architecture it is therefore desirable to do the unlocking
> only for write access. (Note that book3s/32 ranges from very old
> powermac from the 90's with powerpc 601 processor, till modern
> ADSL boxes with PowerQuicc II modern processors for instance so it
> is still worth considering)
> 
> In order to avoid any risk based of hacking some variable parameters
> passed to user_access_begin/end that would allow hacking and
> leaving user access open or opening too much, it is preferable to
> use dedicated static functions that can't be overridden.
> 
> Add a user_read_access_begin and user_read_access_end to only open
> read access.
> 
> Add a user_write_access_begin and user_write_access_end to only open
> write access.
> 
> By default, when undefined, those new access helpers default on the
> existing user_access_begin and user_access_end.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Link: https://patchwork.ozlabs.org/patch/1227926/
> ---
> Resending this series as I mistakenly only sent it to powerpc list
> begining of February (https://patchwork.ozlabs.org/patch/1233172/)
> 
> This series is based on the discussion we had in January, see
> https://patchwork.ozlabs.org/patch/1227926/ . I tried to
> take into account all remarks, especially @hpa 's remark to use
> a fixed API on not base the relocking on a magic id returned at
> unlocking.
> 
> This series is awaited for implementing selective lkdtm test to
> test powerpc64 independant read and write protection, see
> https://patchwork.ozlabs.org/patch/1231765/
> 
>  include/linux/uaccess.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 67f016010aad..9861c89f93be 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -378,6 +378,14 @@ extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
>  static inline unsigned long user_access_save(void) { return 0UL; }
>  static inline void user_access_restore(unsigned long flags) { }
>  #endif
> +#ifndef user_write_access_begin
> +#define user_write_access_begin user_access_begin
> +#define user_write_access_end user_access_end
> +#endif
> +#ifndef user_read_access_begin
> +#define user_read_access_begin user_access_begin
> +#define user_read_access_end user_access_end
> +#endif
>  
>  #ifdef CONFIG_HARDENED_USERCOPY
>  void usercopy_warn(const char *name, const char *detail, bool to_user,
> -- 
> 2.25.0
> 

-- 
Kees Cook

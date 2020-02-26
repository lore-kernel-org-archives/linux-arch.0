Return-Path: <SRS0=ZbOS=4O=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [RFC PATCH v9 11/27] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-12-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <34c83f97-f206-1b43-db40-7e6a7d0f6bb7@intel.com>
Date: Wed, 26 Feb 2020 14:04:43 -0800
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-12-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200226220443.QtYP1FFqieLQ5zily5ZmWJT0MFsO1bgkfN9SojNf1_c@z>

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/=
gtt.c
> index 4b04af569c05..e467ca182633 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -1201,7 +1201,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu =
*vgpu,
>  	}
> =20
>  	/* Clear dirty field. */
> -	se->val64 &=3D ~_PAGE_DIRTY;
> +	se->val64 &=3D ~_PAGE_DIRTY_BITS;
> =20
>  	ops->clear_pse(se);
>  	ops->clear_ips(se);

Are the i915 maintainers on cc?

Shouldn't this use pte_mkclean() instead of open-coding?

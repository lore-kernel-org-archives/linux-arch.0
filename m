From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [RFC PATCH v9 11/27] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
Date: Fri, 03 Apr 2020 08:42:06 -0700
Message-ID: <0ddcfb2630456324203917b78297b00cf5111c9e.camel@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-12-yu-cheng.yu@intel.com>
         <34c83f97-f206-1b43-db40-7e6a7d0f6bb7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <34c83f97-f206-1b43-db40-7e6a7d0f6bb7@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
List-Id: linux-arch.vger.kernel.org

On Wed, 2020-02-26 at 14:04 -0800, Dave Hansen wrote:
> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> > index 4b04af569c05..e467ca182633 100644
> > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > @@ -1201,7 +1201,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
> >  	}
> >  
> >  	/* Clear dirty field. */
> > -	se->val64 &= ~_PAGE_DIRTY;
> > +	se->val64 &= ~_PAGE_DIRTY_BITS;
> >  
> >  	ops->clear_pse(se);
> >  	ops->clear_ips(se);
> 
> Are the i915 maintainers on cc?
> 
> Shouldn't this use pte_mkclean() instead of open-coding?

These functions look like a set of pte_* equivalent for the driver.  They all
use the bits directly.  Add its maintainers to cc.

Yu-cheng

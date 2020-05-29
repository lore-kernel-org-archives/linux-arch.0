Return-Path: <SRS0=ONGt=7L=kvack.org=owner-linux-mm@kernel.org>
In-Reply-To: <ebf1250b6d4f351469fb339e5399d8b92aa8a1c1.1585898438.git.christophe.leroy@c-s.fr>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2 3/5] drm/i915/gem: Replace user_access_begin by user_write_access_begin
Message-ID: <49YBF610M2z9sSw@ozlabs.org>
Date: Fri, 29 May 2020 14:20:25 +1000 (AEST)
Sender: owner-linux-mm@kvack.org
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, keescook@chromium.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, intel-gfx@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200529042025.FS0_vbNY3wErTtgKFLeAyi1EvDga7tE1mqSk5WSMRx0@z>

On Fri, 2020-04-03 at 07:20:52 UTC, Christophe Leroy wrote:
> When i915_gem_execbuffer2_ioctl() is using user_access_begin(),
> that's only to perform unsafe_put_user() so use
> user_write_access_begin() in order to only open write access.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied to powerpc topic/uaccess, thanks.

https://git.kernel.org/powerpc/c/b44f687386875b714dae2afa768e73401e45c21c

cheers

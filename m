From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2 4/5] powerpc/uaccess: Implement user_read_access_begin and user_write_access_begin
Date: Fri, 29 May 2020 14:24:14 +1000 (AEST)
Message-ID: <49YBKW17nhz9sT1@ozlabs.org>
References: <6c83af0f0809ef2a955c39ac622767f6cbede035.1585898438.git.christophe.leroy@c-s.fr>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:47217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgE2EYQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 May 2020 00:24:16 -0400
In-Reply-To: <6c83af0f0809ef2a955c39ac622767f6cbede035.1585898438.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, keescook@chromium.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, intel-gfx@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

On Fri, 2020-04-03 at 07:20:53 UTC, Christophe Leroy wrote:
> Add support for selective read or write user access with
> user_read_access_begin/end and user_write_access_begin/end.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied to powerpc topic/uaccess-ppc, thanks.

https://git.kernel.org/powerpc/c/4fe5cda9f89d0aea8e915b7c96ae34bda4e12e51

cheers

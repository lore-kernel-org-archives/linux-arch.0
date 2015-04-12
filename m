From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH] xtensa: Fix execdomain removal
Date: Sun, 12 Apr 2015 09:43:46 -0500
Message-ID: <20150412144346.GD7215@unpythonic.net>
References: <1428805191-27089-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428805191-27089-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Apr 11, 2015 at 07:19:51PM -0700, Guenter Roeck wrote:
> The removal of exexdomain changes pointer offsets into the thread_info
> structure.
...
> -#define TI_EXEC_DOMAIN	 0x00000004
> -#define TI_FLAGS	 0x00000008
> +#define TI_FLAGS	 0x00000004

Hmm.  If these have to be maintained by hand, perhaps they can be
BUILD_BUG_ON'd in some appropriate C file?  e.g.,

    BUILD_BUG_ON(TI_FLAGS != offsetof(struct thread_info, flags));

Jeff

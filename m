Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:45298 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872AbaAVA06 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jan 2014 19:26:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 31/73] module: relocate module_init from init.h to module.h
In-Reply-To: <1390339396-3479-32-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com> <1390339396-3479-32-git-send-email-paul.gortmaker@windriver.com>
Date: Wed, 22 Jan 2014 10:46:06 +1030
Message-ID: <87ha8w50s9.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Message-ID: <20140122001606.JJEq82ysZCtpoeYMZEs8SyRgdl4zROJ_c4NllgFKNZQ@z>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> Modular users will always be users of init functionality, but
> users of init functionality are not necessarily always modules.
>
> Hence any functionality like module_init and module_exit would
> be more at home in the module.h file.  And module.h should
> explicitly include init.h to make the dependency clear.
>
> We've already done all the legwork needed to ensure that this
> move does not cause any build regressions due to implicit
> header file include assumptions about where module_init lives.
>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Want to delete the extraneous semicolons, for bonus points? :)

> +#define module_init(x)	__initcall(x);
...
> +#define module_exit(x)	__exitcall(x);

Cheers,
Rusty.

From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 39/44] metag: ftrace support
Date: Thu, 10 Jan 2013 10:59:57 -0500
Message-ID: <1357833597.5141.5.camel@gandalf.local.home>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>
	 <1357831872-29451-40-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:21119 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab3AJP77 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jan 2013 10:59:59 -0500
In-Reply-To: <1357831872-29451-40-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

On Thu, 2013-01-10 at 15:31 +0000, James Hogan wrote:

> --- /dev/null
> +++ b/arch/metag/kernel/ftrace.c
> @@ -0,0 +1,127 @@
> +/*
> + * Copyright (C) 2008 Imagination Technologies Ltd.
> + * Licensed under the GPL
> + *
> + * Dynamic ftrace support.
> + */
> +
> +#include <linux/ftrace.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +#include <linux/ftrace.h>

duplicate <linux/ftrace.h>


> +
> +#include <asm/cacheflush.h>
> +
> +#define D04_MOVT_TEMPLATE	0x02200005
> +#define D04_CALL_TEMPLATE	0xAC200005
> +#define D1RTP_MOVT_TEMPLATE	0x03200005
> +#define D1RTP_CALL_TEMPLATE	0xAC200006
> +

The rest looks good.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

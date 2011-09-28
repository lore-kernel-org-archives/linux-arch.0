From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 20/24] C6X: library code
Date: Wed, 28 Sep 2011 16:09:41 +0200
Message-ID: <201109281609.41468.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-21-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317155405-26235-21-git-send-email-msalter@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> +++ b/arch/c6x/include/asm/checksum.h
> @@ -0,0 +1,115 @@
> +/*
> + *  Port on Texas Instruments TMS320C6x architecture
> + *
> + *  Copyright (C) 2004, 2009, 2010 Texas Instruments Incorporated
> + *  Author: Aurelien Jacquiot (aurelien.jacquiot@jaluna.com)
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +#ifndef _ASM_C6X_CHECKSUM_H
> +#define _ASM_C6X_CHECKSUM_H
> +
> +#include <asm/byteorder.h>

I think you should fall back on the generic checksum.h file and only
provide the declarations that are different. This file is largely
identical to the generic version.

	Arnd

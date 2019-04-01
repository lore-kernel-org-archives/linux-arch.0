Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35748 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfDAOaf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 10:30:35 -0400
Date: Mon, 1 Apr 2019 15:30:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/4] arm64: compat: Split kuser32
Message-ID: <20190401143030.GG14874@arrakis.emea.arm.com>
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-3-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401112025.40807-3-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190401143031.9-sEE0TljMj4GX8NCalmj_UeLrcJO58c_CMtaqmxgsw@z>

On Mon, Apr 01, 2019 at 12:20:23PM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
> index 997e6b27ff6a..f19e2b015097 100644
> --- a/arch/arm64/kernel/kuser32.S
> +++ b/arch/arm64/kernel/kuser32.S
> @@ -1,24 +1,9 @@
>  /*
> - * Low-level user helpers placed in the vectors page for AArch32.
> + * AArch32 user helpers.
>   * Based on the kuser helpers in arch/arm/kernel/entry-armv.S.
>   *
>   * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
> - * Copyright (C) 2012 ARM Ltd.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
> - *
> - * AArch32 user helpers.
> + * Copyright (C) 2012-2018 ARM Ltd.

If you remove the license text, please add the SPDX header.

-- 
Catalin

Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E112266576
	for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085076; cv=none; b=oYXvqXwEJimblNougU2txHClF/e3yHzex2+s5Q+hFUFh70m4lbmos9p/yxzE8GUdMlviVZMK4iy66JgobVkEULAPkHzjJcFPN/vV4uxJjz8daF8JWXCxDVDeKDMMij5qkcwns5jd2vsz5k43RNejzciN3xK5KzUaZDEvnruOx2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085076; c=relaxed/simple;
	bh=7hrihdavUKSRBk1sLsO+Hg6KhwRPOnr3OMEgf2c2K3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNvYCqBsR2im6lmsVSoFr8RjIyxHbvwHBmZ9/9ObAGfFdCdC8wXXiC2MYyLUV/kFvBj559Say53shYW29vFiY0ZSAxcCh/7+Ovqfb+B7NgwpC4kjkDQqOFFtqa+CrA75yLDzkJgzTDUdZRK+U2kAm2yK9bjBIRCr25XS913dLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmLw9DXI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmLw9DXI"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso1535899a12.0
        for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 04:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769085071; x=1769689871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WniyRiiurCuuasCidSwYbmBfTajQvRsR2qN3REFSig=;
        b=nmLw9DXINwO0fT8nRSECHf8YSkLFYBOt36dxWZcPy/BiGisjKQUUprYTONfOuwsXMq
         zRm41hvIlIo9waMEDy1/jdQF/ViWlJ1RWtorcFTDey5YvMf5wjuPfWkCvsEqHpzqhd3X
         dEqrpifbXZiwMMMAZcZ7Zi7ndUajas78WZxO4YuPZoTb7MvnqLd+UEyHh1RFrX0LbDfG
         phS5L5ON8NeSWwHNAxx+RPmVAXKcq2DsBKtArRj44x7Iqe1haasGrfjqLHx6MAdoKm7D
         MiE8voxBGyaikpcyu7Gz3N/KDIhajfHz6/uqo2x0gVFgU+Lh5r0FnFluEXO7DqcoYBFs
         pR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769085071; x=1769689871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0WniyRiiurCuuasCidSwYbmBfTajQvRsR2qN3REFSig=;
        b=rnN617K+hFROWhK28ccQJgSv/vdoVdwGod5GpM/Wv/+cXk1qgoOZ58b+oJ2tWpG4ZQ
         twW/tFiYVQj0LKnM3ksVt5Quu1vfbJJXDpoDC3c4KaxHWn6kEgyJJwh1f65/+n8T34jR
         fEB3uKB+EZJXV4zkizZ96cW/Fcd8MHDNf2K2BC0vAf/nxhD1CaGVqLBOkZudG//5Wugq
         Uq0dTvxdr7jtfcnk1ZGqS0y7IJbRXUhfpV6zEA8TWErNDQqnq09JjNbfbjyhvC/hW+VT
         BVmDBA0WALPnbzAIbs6cPX66vIYl8yrDurYAwiFJOJEWk0c7rJ+uXIg8yir/xE4WweWI
         G/0w==
X-Forwarded-Encrypted: i=1; AJvYcCVZyYGXj09U98JUoRTicfSIRtC10dNYi2GqnzawmmJg4iUhND+KLxj4lGjEwlVlKw8HRaF1UP/+7Qvi@vger.kernel.org
X-Gm-Message-State: AOJu0YxfkMwQQNVNooQ+YmkOsZUqFMC19af56LrJriVzKOIiS77M6dEc
	i26p7qj+gD13sAOrMeMvyjGVanqDDZAnTZNVbHTCRwhs0Saawme8a8xFV2Mcvw==
X-Gm-Gg: AZuq6aIGfbO4i5gjHEEVKFjOKogXBfNxh17HtnSYm8UzRuE+iGk7U5iewPiwlvppbxB
	lzNkY+zViDKrnk9/1ZMAB3uzYIM1+xv8mtXgKPH7DLS7xRSc+VWQC5DyMHisOTXObg/ItLgSDp/
	ePAXVKbtJIjyRsQ3NMyzu22916efJ1swv+yaV7FraQU0qJnvZ1KlemBDkTaFJmrK/kfXC1XRFg4
	/Uv+OYgLNfm2GK0cflc5vz4S2bkQvs88hcmKF2uMyGF5kBQbLbgyBmunjFbMUKqH3o4HnL8pS83
	5k4CcdayP2yKXRVHhRhl4x/4AURRlen4VnAlSEAYVhqb5GjgdB49tNh1jo3JEVTOnf93yG0ALc/
	qBPxuSecdCXWsX8bdolsFlj3HWvQubXSpRbALAF+F5SS2agHX/UzSP9rH2Rbdn4aD7SGQX8gHdn
	onnthyctePcOTeiIPJfZW+yuPLvx5B4zuxFUo56PEh8Sdeao+VG9UC
X-Received: by 2002:a05:600c:2d92:b0:47d:87ac:73ef with SMTP id 5b1f17b1804b1-480470c7513mr21530765e9.13.1769077831210;
        Thu, 22 Jan 2026 02:30:31 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48048b49880sm44067865e9.11.2026.01.22.02.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:30:30 -0800 (PST)
Date: Thu, 22 Jan 2026 10:30:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yury Norov
 <yury.norov@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>
Subject: Re: [PATCH next 12/14] bits: move the defitions of BIT() and
 BIT_ULL() back to linux/bits.h
Message-ID: <20260122103029.255b3dd3@pumpkin>
In-Reply-To: <202601220951.7C4YG7hB-lkp@intel.com>
References: <20260121145731.3623-13-david.laight.linux@gmail.com>
	<202601220951.7C4YG7hB-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 09:23:16 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on next-20260120]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/overflow-Reduce-expansion-of-__type_max/20260122-013456
> base:   next-20260120
> patch link:    https://lore.kernel.org/r/20260121145731.3623-13-david.laight.linux%40gmail.com
> patch subject: [PATCH next 12/14] bits: move the defitions of BIT() and BIT_ULL() back to linux/bits.h
> config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260122/202601220951.7C4YG7hB-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601220951.7C4YG7hB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601220951.7C4YG7hB-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from kernel/bounds.c:14:
>    In file included from include/linux/log2.h:12:
>    In file included from include/linux/bitops.h:28:
>    In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
>    In file included from arch/arm64/include/asm/barrier.h:14:
> >> arch/arm64/include/asm/alternative-macros.h:18:20: warning: 'unsigned' is not defined, evaluates to 0 [-Wundef]  
>       18 | #if ARM64_NCAPS >= ARM64_CB_BIT
...
> 
> 4c0bd995d73ed8 Mark Rutland 2022-09-12  17  
> 4c0bd995d73ed8 Mark Rutland 2022-09-12 @18  #if ARM64_NCAPS >= ARM64_CB_BIT
> 4c0bd995d73ed8 Mark Rutland 2022-09-12  19  #error "cpucaps have overflown ARM64_CB_BIT"
> 4c0bd995d73ed8 Mark Rutland 2022-09-12  20  #endif
> 7cda23da52ad79 Will Deacon  2020-06-30  21  

Unless I change BIT() back I'll change that to a static_assert().

	David


From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 0/3] Ensure inX() is ordered wrt delay() routines
Date: Thu, 28 Feb 2019 17:37:58 +0000
Message-ID: <20190228173758.GD226495@arrakis.emea.arm.com>
References: <20190222180454.5992-1-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222180454.5992-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de, geert@linux-m68k.org, palmer@sifive.com
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 22, 2019 at 06:04:51PM +0000, Will Deacon wrote:
> Will Deacon (3):
>   asm-generic/io: Pass result of I/O accessor to __io_[p]ar()
>   riscv: io: Update __io_[p]ar() macros to take an argument
>   arm64: io: Hook up __io_par() for inX() ordering

Since we have the acks in place, I plan to queue these patches via the
arm64 tree. They don't conflict with -next (as of today) but if anyone
expects other issues, please let me know.

-- 
Catalin

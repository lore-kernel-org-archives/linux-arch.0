Return-Path: <SRS0=lzY1=6F=kvack.org=owner-linux-mm@kernel.org>
Date: Tue, 21 Apr 2020 16:29:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 20/23] fs: Allow copy_mount_options() to access
 user-space in a single pass
Message-ID: <20200421152948.GC23230@ZenIV.linux.org.uk>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-21-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421142603.3894-21-catalin.marinas@arm.com>
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200421152948.5yH_a2dk35TNEAEk4xgqwvJh5ygasrSXCXvPSTYfGAg@z>

On Tue, Apr 21, 2020 at 03:26:00PM +0100, Catalin Marinas wrote:

> While this function is not on a critical path, the single-pass behaviour
> is required for arm64 MTE (memory tagging) support where a uaccess can
> trigger intra-page faults (tag not matching). With the current
> implementation, if this happens during the first page, the function will
> return -EFAULT.

Details, please.

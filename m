From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH 0/2] arm64: support initrd outside of mapped RAM
Date: Wed, 29 Jul 2015 10:20:38 +0100
Message-ID: <1438161638.3129.4.camel@linaro.org>
References: <1438093961-15536-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1438093961-15536-1-git-send-email-msalter@redhat.com>
Sender: owner-linux-mm@kvack.org
To: Mark Salter <msalter@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, "Arnd Bergmann <arnd@arndb.de>--cc=Ard
 Biesheuvel" <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2015-07-28 at 10:32 -0400, Mark Salter wrote:
> When booting an arm64 kernel w/initrd using UEFI/grub, use of mem= will likely
> cut off part or all of the initrd. This leaves it outside the kernel linear
> map which leads to failure when unpacking.

Have we got a similar issue for the device-tree blob?

-- 
Tixy

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from queue01c.mail.zen.net.uk ([212.23.3.237]:45845 "EHLO
	queue01c.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbG2JmU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jul 2015 05:42:20 -0400
Received: from [212.23.1.7] (helo=smarthost01d.mail.zen.net.uk)
	by queue01c.mail.zen.net.uk with esmtp (Exim 4.72)
	(envelope-from <tixy@linaro.org>)
	id 1ZKNXv-00047j-3O
	for linux-arch@vger.kernel.org; Wed, 29 Jul 2015 09:21:07 +0000
Message-ID: <1438161638.3129.4.camel@linaro.org>
Subject: Re: [PATCH 0/2] arm64: support initrd outside of mapped RAM
From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Date: Wed, 29 Jul 2015 10:20:38 +0100
In-Reply-To: <1438093961-15536-1-git-send-email-msalter@redhat.com>
References: <1438093961-15536-1-git-send-email-msalter@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, "Arnd Bergmann <arnd@arndb.de>--cc=Ard Biesheuvel" <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20150729092038.Q0y85DqGqYYPuNcM-zpXMqtUlhwrkUDm5vvwBkPdPzg@z>

On Tue, 2015-07-28 at 10:32 -0400, Mark Salter wrote:
> When booting an arm64 kernel w/initrd using UEFI/grub, use of mem= will likely
> cut off part or all of the initrd. This leaves it outside the kernel linear
> map which leads to failure when unpacking.

Have we got a similar issue for the device-tree blob?

-- 
Tixy


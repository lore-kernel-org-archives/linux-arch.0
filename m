From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 21/25] tile: Use Kbuild infrastructure for kvm_para.h
Date: Sun, 14 Oct 2012 13:11:47 -0400
Message-ID: <507AF253.1030108@tilera.com>
References: <20121013022632.024527228@goodmis.org> <20121013022955.456205573@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:21561 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab2JNRLr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 14 Oct 2012 13:11:47 -0400
In-Reply-To: <20121013022955.456205573@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>


On 10/12/2012 10:26 PM, Steven Rostedt wrote:
> From: Steven Rostedt <srostedt@redhat.com>
>
> All the headers but kvm_para.h use the Kbuild infrastructure to
> get to the asm-generic headers.
>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  arch/tile/include/asm/Kbuild     |    1 +
>  arch/tile/include/asm/kvm_para.h |    1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  delete mode 100644 arch/tile/include/asm/kvm_para.h

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

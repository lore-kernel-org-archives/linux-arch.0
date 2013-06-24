From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH 09/16] metag: locks: remove unused arch_*_relax operations
Date: Mon, 24 Jun 2013 10:07:16 +0100
Message-ID: <51C80C44.8000500@imgtec.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com> <1371835057-19335-10-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:34537 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741Ab3FXJHS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 24 Jun 2013 05:07:18 -0400
In-Reply-To: <1371835057-19335-10-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org

On 21/06/13 18:17, Will Deacon wrote:
> The arch_{spin,read,write}_relax macros are not used anywhere in the
> kernel and are typically just aliases for cpu_relax().
> 
> This patch removes the unused definitions for Metag, including duplicate
> definitions of arch_{read,write}_lock_flags.
> 
> Cc: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

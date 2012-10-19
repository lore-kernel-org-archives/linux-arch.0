From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RESEND PATCH 4/4] net: smc91x: use io{read,write}*_rep accessors
 instead of string functions
Date: Fri, 19 Oct 2012 09:25:48 +0100
Message-ID: <50810E8C.5010806@imgtec.com>
References: <1350488704-3711-1-git-send-email-will.deacon@arm.com> <1350488704-3711-5-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350488704-3711-5-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ben Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

On 17/10/12 16:45, Will Deacon wrote:
> The {read,write}s{b,w,l} operations are not defined by all architectures
> and are being removed from the asm-generic/io.h interface.
> 
> This patch replaces the usage of these string functions in the default
> SMC accessors with io{read,write}{8,16,32}_rep calls instead, which are
> defined for all architectures.

Hi,

Should this patch (and the mmc one) precede patch 1?

Also there appear to be some other places that it's used (e.g.
smsc911x.c and smc911x.h). I guess these should be fixed up first too?

Cheers
James

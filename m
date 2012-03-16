From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] Remove unneeded EXPORT macro
Date: Thu, 15 Mar 2012 21:06:35 -0300
Message-ID: <20120316000635.GA13145@amt.cnet>
References: <1331849809-17034-1-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331849809-17034-1-git-send-email-emunson@mgebm.net>
Sender: kvm-owner@vger.kernel.org
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, jan.kiszka@siemens.com, avi@redhat.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 15, 2012 at 06:16:49PM -0400, Eric B Munson wrote:
> check_and_clear_guest_paused does not need to be exported as it isn't used
> by any modules, remove the export.
> 
> Signed-off-by: Eric B Munson <emunson@mgebm.net>
> Cc: mingo@redhat.com
> Cc: hpa@zytor.com
> Cc: ryanh@linux.vnet.ibm.com
> Cc: aliguori@us.ibm.com
> Cc: jan.kiszka@siemens.com
> Cc: avi@redhat.com
> Cc: kvm@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kernel/kvmclock.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Applied, thanks.


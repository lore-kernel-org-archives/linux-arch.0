From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 48/73] drivers/ata: delete non-required instances of
 include <linux/init.h>
Date: Thu, 13 Feb 2014 16:41:46 -0500
Message-ID: <20140213214146.GI17608@htj.dyndns.org>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-49-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390339396-3479-49-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-ide-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 21, 2014 at 04:22:51PM -0500, Paul Gortmaker wrote:
> None of these files are actually using any __init type directives
> and hence don't need to include <linux/init.h>.  Most are just a
> left over from __devinit and __cpuinit removal, or simply due to
> code getting copied from one driver to the next.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun

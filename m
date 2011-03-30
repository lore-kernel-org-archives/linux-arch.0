From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] unicore32 ldscript fix: add cacheline parameter to PERCPU() macro
Date: Wed, 30 Mar 2011 11:31:58 +0200
Message-ID: <201103301131.59054.arnd@arndb.de>
References: <01ed01cbeeb7$de2e1920$9a8a4b60$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01ed01cbeeb7$de2e1920$9a8a4b60$@mprc.pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wednesday 30 March 2011, Guan Xuetao wrote:
> 
> Also, adjust cacheline parameter of RW_DATA_SECTION and EXCEPTION_TABLE
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Acked-by: Arnd Bergmann <arnd@arndb.de>

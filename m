From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/17] unicore32 machine related: add frame buffer driver for pkunity-v3 soc
Date: Mon, 28 Feb 2011 16:18:03 +0100
Message-ID: <201102281618.03890.arnd@arndb.de>
References: <cover.1298821856.git.epip@hera.kernel.org> <a336d8ba89b5afe129cb9178f26216b22d6beb63.1298821856.git.epip@hera.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a336d8ba89b5afe129cb9178f26216b22d6beb63.1298821856.git.epip@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <epip@hera.kernel.org>
Cc: GuanXuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com
List-Id: linux-arch.vger.kernel.org

On Sunday 27 February 2011, Guan Xuetao wrote:
> From: GuanXuetao <gxt@mprc.pku.edu.cn>
> 
> change from original version -- by advice of Paul Mundt
> 1. remove videomemorysize definitions
> 2. remove unifb_enable and unifb_setup
> 3. use dev_warn instead of printk in fb driver
> 4. remove judgement for FB_ACCEL_PUV3_UNIGFX
> 5. adjust clk_get and clk_set_rate calls
> 6. add resources definitions
> 7. remove unifb_option
> 8. adjust register for platform_device
> 9. adjust unifb_ops position and unifb_regs assignment position
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Acked-by: Arnd Bergmann <arnd@arndb.de>

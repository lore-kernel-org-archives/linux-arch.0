From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/9] dt: Handle passed/built-in DT selection in early_init_dt_scan()
Date: Tue, 19 Nov 2013 13:27:28 +0000
Message-ID: <528B6740.1030402@imgtec.com>
References: <5283A000.8090007@gmail.com> <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 19/11/13 11:12, Geert Uytterhoeven wrote:
> Let early_init_dt_scan() fall-back to the built-in DT if no DT was passed,
> or if it's invalid, so architectures don't have to duplicate this logic.
> 
> Suggested-by: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

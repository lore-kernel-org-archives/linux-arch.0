From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/5] dma-mapping: add dma_{map,unmap}_page_attrs
Date: Mon, 25 Jan 2016 10:09:41 +0100
Message-ID: <1926814.s3ZxygyFZe@wuerfel>
References: <1453384895-20395-1-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1453384895-20395-2-git-send-email-niklas.soderlund+renesas@ragnatech.se> <1989275.WS6Og0GPnT@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1989275.WS6Og0GPnT@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org, vinod.koul@intel.com, linus.walleij@linaro.org, geert+renesas@glider.be, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sunday 24 January 2016 22:43:57 Laurent Pinchart wrote:
> Hi Niklas,
>=20
> (CC'ing LKML, linux-arch and Arnd Bergmann)
>=20
> Thank you for the patch.
>=20
> On Thursday 21 January 2016 15:01:31 Niklas S=F6derlund wrote:
> > Add a version of dmap_{map,unmap}_page that can pass on attributes =
to
> > the underlaying map_page. This already exists for dma_{map,unmap}_s=
ingle
> > and dmap_{map,unmap}_sg versions.
> >=20
> > Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnate=
ch.se>
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20

The patch looks fine, but won't apply any more now that the code has
been moved to include/linux/dma-mapping.h

	Arnd

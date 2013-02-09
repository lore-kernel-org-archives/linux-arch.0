From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/9] gpiolib: use gpio_chips list in gpiochip_find
Date: Sat, 09 Feb 2013 09:25:25 +0000
Message-ID: <20130209092525.9F9A23E2C48@localhost>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-5-git-send-email-acourbot@nvidia.com>
 <CACRpkdaVwjv2DwSx667sgVkHqx-tHsy6A0mP-kvq6h9nDDBrGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdaVwjv2DwSx667sgVkHqx-tHsy6A0mP-kvq6h9nDDBrGA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-arch@vger.kernel.org, gnurou@gmail.com, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 5 Feb 2013 18:05:32 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > Using the GPIO chips list is much faster than parsing the entire GPIO
> > number space.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> You don't say :-)
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

g.

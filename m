From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 8/9] gpiolib: use gpio_chips list in gpio_to_desc
Date: Tue, 5 Feb 2013 19:01:34 +0100
Message-ID: <CACRpkdbXvf8mRgpr2MrmcJcT1gTg4mfBOnF8s3=+jS5iAcMtkQ@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-10-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1359822572-26009-10-git-send-email-acourbot@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-arch@vger.kernel.org, gnurou@gmail.com, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Parse the list of chips to find the descriptor corresponding to a GPIO
> number instead of directly picking the entry of the global gpio_desc[]
> array, which is due to be removed.
>
> This turns the complexity of converting a GPIO number into a descriptor
> from O(1) to O(n) where n is the number of GPIO chips in the system.
> Since n is ought to be small anyway, there should be no noticeable
> performance impact. Moreover, GPIO users who care for speed already have
> implemented their own gpio_get_value() and gpio_set_value() with a
> fast path for the GPIO numbers that matter and this change does not
> affect such use cases.
>
> The descriptor-based GPIO API, due to be introduced soon, will make this
> lookup unnecessary.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

OK it's a nice stepping stone.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

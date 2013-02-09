From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/9] gpiolib: use gpio_chips list in sysfs ops
Date: Sat, 09 Feb 2013 09:37:53 +0000
Message-ID: <20130209093753.654C53E2C59@localhost>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-6-git-send-email-acourbot@nvidia.com>
 <CACRpkdaC3pu3tBZrw0Az226XEt6+AzJ_NiiCaLwV9o6NUZ8MQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdaC3pu3tBZrw0Az226XEt6+AzJ_NiiCaLwV9o6NUZ8MQw@mail.gmail.com>
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

On Tue, 5 Feb 2013 18:15:54 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > This makes the code both simpler and faster compared to parsing the GPIO
> > number space.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

However, this code is incorrect (it was incorrect before you touched it,
so not your fault). Moving it to a list makes it a lot worse though
because it introduces the possibility of dereferencing an invalid
pointer. The hooks need to grab the spinlock before parsing the list.

I've got a patch which I'll post. I'd appreciate it if you can test
also.

In actual fact, I'd like to replace the spinlock with a mutex, but that
requires some auditing to make sure there aren't any users from an
atomic context.

g.

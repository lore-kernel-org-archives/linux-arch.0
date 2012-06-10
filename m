From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 0/6] Bridging PCI to amba
Date: Sun, 10 Jun 2012 18:36:17 +0200
Message-ID: <CACRpkdbPtR5MDjd1YZ5GhOdp61HQe2PJusudNPOhDQHUAt1kJA@mail.gmail.com>
References: <cover.1338220457.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1338220457.git.rubini@gnudd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alessandro Rubini <rubini@gnudd.com>
Cc: linux-arch@vger.kernel.org, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Mon, May 28, 2012 at 6:36 PM, Alessandro Rubini <rubini@gnudd.com> wrote:

> V2: accepted comments I got on V1; rewritten the driver to be generic;
> =A0 =A0made it tristate instead of boolean. Rebased on new next.

This looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think this patch set could go through Arnd as arch maintainer?
It's fun with these cross-arch things. You'll need an ACK from
Russell first.

Yours,
Linus Walleij

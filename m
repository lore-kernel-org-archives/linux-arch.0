From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -v12 01/15] resources: Split out __allocate_resource()
Date: Tue, 26 Jun 2012 12:01:19 -0700
Message-ID: <CA+55aFzi7tHg=3k8Fmga8XmxFbn6tZLLV97vt67Xx_WtckQo6g@mail.gmail.com>
References: <1340736849-14875-1-git-send-email-yinghai@kernel.org> <1340736849-14875-2-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340736849-14875-2-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 26, 2012 at 11:53 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> It will take bool lock, so we could use it in other functions that
> hold the resource lock already.

This is too damn ugly.

These kinds of "conditionally take lock" things are always just bugs
waiting to happen. Don't do it.

Just make the rule be that the caller of the __allocate_resource
helper has to hold the lock. Sure, that means that you need to then
use split reallocate_resource() into a helper function (ie a static
__reallocate_resource() that needs to have the lock taken by the
caller too), but dammit, that's definitely the right thing to do
anyway.

These kinds of "bool lock" crap things have to die. They are *wrong*.
They are a sign of bad locking rules.

                  Linus

From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Overlapping ioremap() calls, set_memory_*() semantics
Date: Thu, 3 Mar 2016 13:28:27 -0800
Message-ID: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-arch.vger.kernel.org

At kernel summit, during the semantics of ioremap() session, Paul
mentioned we'd write something up to help get some notes out on what
we need to do and help clarify things. I've run into an issue (just a
warning) with a user on some odd system that I suspect may be the
result of a driver using overlapping ioremap() calls on conflicting
memory regions, so I'm a bit interested to see a resolution to some of
these lingering discussions now.

Although we spoke of quite a bit of things, I raised in particular the
'semantics of overlapping ioremap()' calls as one item of interest we
should address across architectures. At least on x86 it seems we would
not get an error if this is done and in fact its expected behavior;
Toshi had determined we could not enable error'ing out on overlapping
ioremap() calls given we have a few users that use it intentionally,
for instance the /dev/mem setup code. I had suggested long ago then
that one possible resolution was for us to add an API that *enables*
overlapping ioremap() calls, and only use it on select locations in
the kernel. This means we only have to convert a few users to that
call to white list such semantics, and by default we'd disable
overlapping calls. To kick things off -- is this strategy agreeable
for all other architectures?

The problem is that without this it remains up to the developer of the
driver to avoid overlapping calls, and a user may just get sporadic
errors if this happens.  As another problem case, set_memor_*() will
not fail on MMIO even though set_memor_*() is designed only for RAM.
If the above strategy on avoiding overlapping is agreeable, could the
next step, or an orthogonal step be to error out on set_memory_*() on
IO memory?

  Luis

From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 07/34] sparc: reuse asm-generic/barrier.h
Date: Wed, 30 Dec 2015 15:47:39 -0500 (EST)
Message-ID: <20151230.154739.2088097882831259841.davem@davemloft.net>
References: <1451473761-30019-8-git-send-email-mst@redhat.com>
	<20151230.125603.75638711551088484.davem@davemloft.net>
	<20151230215303-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151230215303-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, stefano.stabellini@eu.citrix.com, peterz@infradead.org, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, andreyknvl@google.com, virtualization@lists.linux-foundation.org, mpe@ellerman.id.au, sparclinux@vger.kernel.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 30 Dec 2015 21:55:33 +0200

> The problem I had in the past is that vger rejects email with
> too many CC addresses.

I can't think of a patch set where a > 1024 character CC: list is
legitimate anyways, even if all interested parties are included.

> I'll look for better solutions next time - for now, would it help if I
> bounced the whole patchset to you?

Not necessary, I provided a reply to your 00/NN repost.

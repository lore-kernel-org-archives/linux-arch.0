From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select m68knommu contributions
Date: Thu, 02 Sep 2010 16:12:38 +0100
Message-ID: <24082.1283440358@redhat.com>
References: <20100902135438.GA23729@merkur.ravnborg.org> <19747.1283422807@redhat.com> <20100902102158.19806.14133.stgit@warthog.procyon.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100902135438.GA23729@merkur.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dhowells@redhat.com, gerg@snapgear.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:

> This was exactly the reason why __uClinux__ was used in the first place.

That shouldn't be used in kernel headers.  It should be !CONFIG_MMU.

David

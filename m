From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
Date: Thu, 15 Mar 2018 10:56:48 +0100
Message-ID: <CAK8P3a10hBz7QYk5v5MfhVMPOwFnWYTn95WZp1HtHrd7-GQpRg@mail.gmail.com>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2929.1521106970@warthog.procyon.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-spi <linux-spi@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-rtc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCBNYXIgMTUsIDIwMTggYXQgMTA6NDIgQU0sIERhdmlkIEhvd2VsbHMgPGRob3dlbGxz
QHJlZGhhdC5jb20+IHdyb3RlOgo+IERvIHdlIGhhdmUgYW55dGhpbmcgbGVmdCB0aGF0IHN0aWxs
IGltcGxlbWVudHMgTk9NTVU/CgpZZXMsIHBsZW50eS4gSSB3YXMgd29uZGVyaW5nIHRoZSBzYW1l
IHRoaW5nLCBidXQgaXQgc2VlbXMgdGhhdCB0aGUgYXJjaGl0ZWN0dXJlcwp3ZSByZW1vdmUgYXJl
IGFsbW9zdCBjb21wbGV0ZWx5IHJlcHJlc2VudGF0aXZlIG9mIHdoYXQgd2Ugc3VwcG9ydCBvdmVy
YWxsLApleGNlcHQgdGhhdCB0aGV5IGFyZSBhbGwgbm90IGxpY2Vuc2VkIHRvIDNyZCBwYXJ0aWVz
LCB1bmxpa2UgbWFueSBvZiB0aGUgb25lcyB3ZQprZWVwLgoKSSd2ZSBtYWRlIGFuIG92ZXJ2aWV3
IG9mIHRoZSByZW1haW5pbmcgYXJjaGl0ZWN0dXJlcyBmb3IgbXkgb3duIHJlZmVyZW5jZVsxXS4K
VGhlIHJlbWFpbmluZyBOT01NVSBhcmNoaXRlY3R1cmVzIGFyZToKCi0gYXJjaC9hcm0gaGFzIEFS
TXY3LU0gKENvcnRleC1NIG1pY3JvY29udHJvbGxlciksIHdoaWNoIGlzIGFjdHVhbGx5CmdhaW5p
bmcgdHJhY3Rpb24KLSBhcmNoL3NoIGhhcyBhbiBvcGVuLXNvdXJjZSBKMiBjb3JlIHRoYXQgd2Fz
IGFkZGVkIG5vdCB0aGF0IGxvbmcgYWdvLAppdCBzZWVtcyB0bwogIGJlIHRoZSBvbmx5IFNIIGNv
bXBhdGlibGUgY29yZSB0aGF0IGFueW9uZSBpcyB3b3JraW5nIG9uLgotIGFyY2gvbWljcm9ibGF6
ZSBzdXBwb3J0cyBib3RoIE1NVS9OT01NVSBtb2RlcyAobW9zdCB1c2UgYW4gTU1VKQotIGFyY2gv
bTY4ayBzdXBwb3J0cyBzZXZlcmFsIE5PTU1VIHRhcmdldHMsIGJvdGggdGhlIGNvbGRmaXJlIFNv
Q3MgYW5kIHRoZQogIGNsYXNzaWMgcHJvY2Vzc29ycwotIGM2eCBoYXMgbm8gTU1VCgogICAgICAg
QXJuZAoKWzFdIGh0dHBzOi8vZG9jcy5nb29nbGUuY29tL3NwcmVhZHNoZWV0cy9kLzFReE12VzVq
cFZHMmpiNFJNOUNRUWwyNy13VnBOWU9hLV8zSzJSVktpZmIwCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=

From: "Kani, Toshi" <toshi.kani@hpe.com>
Subject: Re: [PATCH v9 3/4] arm64: Implement page table free interfaces
Date: Wed, 23 May 2018 14:34:06 +0000
Message-ID: <1527085967.14039.10.camel@hpe.com>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
         <1525074094-25839-4-git-send-email-cpandya@codeaurora.org>
         <20180523140157.GG26965@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523140157.GG26965@arm.com>
Content-Language: en-US
Content-ID: <19B70EC0430CDD48AEAFE53AFF6E7F8E@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>, "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "james.morse@arm.com" <james.morse@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>
List-Id: linux-arch.vger.kernel.org

T24gV2VkLCAyMDE4LTA1LTIzIGF0IDE1OjAxICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
SGkgQ2hpbnRhbiwNCj4gDQo+IFthcyBhIHNpZGUgbm90ZTogSSdtIGNvbmZ1c2VkIG9uIHRoZSBz
dGF0dXMgb2YgdGhpcyBwYXRjaCBzZXJpZXMsIGFzIHBhcnQNCj4gIG9mIGl0IHdhcyByZXBvc3Rl
ZCBzZXBhcmF0ZWx5IGJ5IFRvc2hpLiBQbGVhc2UgY2FuIHlvdSB3b3JrIHRvZ2V0aGVyP10NCg0K
SSBkbyBub3Qga25vdyB0aGUgc3RhdHVzIG9mIG15IHBhdGNoIHNlcmllcywgZWl0aGVyLi4uIFRo
YXQgYmVpbmcgc2FpZCwNCkkgbWFkZSBteSB4ODYgcGF0Y2hlcyBiYXNlZCBvZmYgZnJvbSBDaGlu
dGFuJ3MgMS80IHBhdGNoICh3aGljaCBjaGFuZ2VzDQpib3RoIHg4NiBhbmQgYXJtKSBzbyB0aGF0
IG15IHNlcmllcyB3b24ndCBjb25mbGljdCB3aXRoIGhpcy4NCg0KQ2hpbnRhbiwNCklmIHlvdSBu
ZWVkIHRvIHVwZGF0ZSB5b3VyIHNlcmllcyBiZWZvcmUgbWluZSdzIGFjY2VwdGVkLCBwbGVhc2Ug
bWFrZQ0Kc3VyZSB0byB1c2UgdGhlIHVwZGF0ZWQgMS80IGJlbG93LiBJJ3ZlIHVwZGF0ZWQgdGhl
IGRlc2NyaXB0aW9ucyBwZXINCnJldmlldyBjb21tZW50Lg0KaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wYXRjaC8xMDQwNzA2NS8NCg0KVGhhbmtzLA0KLVRvc2hpIA==
